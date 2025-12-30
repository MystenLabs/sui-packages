module 0x2e729333ca15e59067507c3ef26bed95491bed57b5811b7510d703b13816db57::jablixnft {
    struct JABLIXNFT has drop {
        dummy_field: bool,
    }

    struct Inventory has key {
        id: 0x2::object::UID,
        count: u64,
    }

    struct Jablix has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
        hp: u64,
        speed: u64,
        energy: u64,
        strength: u64,
    }

    struct JablixMinted has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
        type_id: u8,
        name: 0x1::string::String,
        current_supply: u64,
        price_paid: u64,
    }

    struct JablixBurned has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
    }

    struct Rentables has drop {
        dummy_field: bool,
    }

    struct Rented has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct Listed has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct Rentable has store {
        object: Jablix,
        duration: u64,
        start_date: 0x1::option::Option<u64>,
        price_per_day: u64,
        kiosk_id: 0x2::object::ID,
    }

    struct RentalPolicy has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        amount_bp: u64,
    }

    struct ProtectedTP has store, key {
        id: 0x2::object::UID,
        transfer_policy: 0x2::transfer_policy::TransferPolicy<Jablix>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<Jablix>,
    }

    public fun list(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &ProtectedTP, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk_extension::is_installed<Rentables>(arg0), 0);
        0x2::kiosk::set_owner(arg0, arg1, arg6);
        0x2::kiosk::list<Jablix>(arg0, arg1, arg3, 0);
        let (v0, v1) = 0x2::kiosk::purchase<Jablix>(arg0, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<Jablix>(&arg2.transfer_policy, v1);
        let v5 = Rentable{
            object        : v0,
            duration      : arg4,
            start_date    : 0x1::option::none<u64>(),
            price_per_day : arg5,
            kiosk_id      : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
        };
        let v6 = Rentables{dummy_field: false};
        let v7 = Listed{id: arg3};
        0x2::bag::add<Listed, Rentable>(0x2::kiosk_extension::storage_mut<Rentables>(v6, arg0), v7, v5);
    }

    public fun url(arg0: &Jablix) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: Jablix, arg1: &mut 0x2::tx_context::TxContext) {
        let Jablix {
            id       : v0,
            name     : _,
            url      : _,
            hp       : _,
            speed    : _,
            energy   : _,
            strength : _,
        } = arg0;
        0x2::object::delete(v0);
        let v7 = JablixBurned{
            object_id : 0x2::object::id<Jablix>(&arg0),
            owner     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<JablixBurned>(v7);
    }

    public fun delist(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &ProtectedTP, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 1);
        let v0 = Rentables{dummy_field: false};
        let v1 = Listed{id: arg3};
        let Rentable {
            object        : v2,
            duration      : _,
            start_date    : _,
            price_per_day : _,
            kiosk_id      : _,
        } = 0x2::bag::remove<Listed, Rentable>(0x2::kiosk_extension::storage_mut<Rentables>(v0, arg0), v1);
        0x2::kiosk::place<Jablix>(arg0, arg1, v2);
    }

    public fun end_rental(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: &ProtectedTP, arg3: &0x2::clock::Clock, arg4: 0x2::object::ID, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Rentables{dummy_field: false};
        let v1 = Rented{id: arg4};
        let Rentable {
            object        : v2,
            duration      : v3,
            start_date    : v4,
            price_per_day : _,
            kiosk_id      : v6,
        } = 0x2::bag::remove<Rented, Rentable>(0x2::kiosk_extension::storage_mut<Rentables>(v0, arg1), v1);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg0) == v6, 4);
        assert!(0x2::clock::timestamp_ms(arg3) >= 0x1::option::destroy_some<u64>(v4) + v3 * 86400000, 5);
        0x2::kiosk::place<Jablix>(arg0, arg5, v2);
    }

    public fun energy(arg0: &Jablix) : u64 {
        arg0.energy
    }

    fun get_stats_for_type(arg0: u8) : (u64, u64, u64, u64) {
        let v0 = vector[110, 100, 100, 90, 120, 130, 140, 80, 85, 90, 95, 85, 100, 105, 150, 145, 115, 105, 110, 115, 100, 140, 130, 160, 170, 140, 145, 200, 210, 155, 160];
        let v1 = vector[65, 55, 70, 60, 70, 80, 40, 100, 105, 50, 75, 65, 60, 65, 40, 35, 75, 70, 90, 95, 60, 95, 140, 110, 120, 90, 105, 80, 70, 100, 130];
        let v2 = vector[75, 65, 70, 80, 65, 75, 80, 110, 115, 100, 85, 90, 70, 75, 80, 85, 70, 75, 80, 85, 70, 110, 140, 110, 115, 130, 120, 110, 100, 110, 110];
        let v3 = vector[75, 80, 65, 75, 80, 85, 110, 50, 55, 120, 60, 75, 70, 70, 110, 115, 75, 70, 80, 85, 70, 105, 80, 120, 125, 150, 110, 140, 150, 105, 110];
        let v4 = (arg0 as u64) - 1;
        (*0x1::vector::borrow<u64>(&v0, v4), *0x1::vector::borrow<u64>(&v1, v4), *0x1::vector::borrow<u64>(&v2, v4), *0x1::vector::borrow<u64>(&v3, v4))
    }

    public fun hp(arg0: &Jablix) : u64 {
        arg0.hp
    }

    fun init(arg0: JABLIXNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"hp"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"speed"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"energy"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"strength"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"website"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Jablix NFT - Unique monster with stats for battle. Part of Drariux Network ecosystem."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{hp}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{speed}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{energy}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{strength}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Drariux Network"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://drariux.network"));
        let v4 = 0x2::package::claim<JABLIXNFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Jablix>(&v4, v0, v2, arg1);
        0x2::display::update_version<Jablix>(&mut v5);
        let v6 = Inventory{
            id    : 0x2::object::new(arg1),
            count : 0,
        };
        let (v7, v8) = 0x2::transfer_policy::new<Jablix>(&v4, arg1);
        let v9 = ProtectedTP{
            id              : 0x2::object::new(arg1),
            transfer_policy : v7,
            policy_cap      : v8,
        };
        let v10 = RentalPolicy{
            id        : 0x2::object::new(arg1),
            balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            amount_bp : 0,
        };
        0x2::transfer::public_share_object<ProtectedTP>(v9);
        0x2::transfer::public_share_object<RentalPolicy>(v10);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, @0x9e7aaf5f56ae094eadf9ca7f2856f533bcbf12fcc9bb9578e43ca770599a5dce);
        0x2::transfer::public_transfer<0x2::display::Display<Jablix>>(v5, @0x9e7aaf5f56ae094eadf9ca7f2856f533bcbf12fcc9bb9578e43ca770599a5dce);
        0x2::transfer::share_object<Inventory>(v6);
    }

    public fun install_extension(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Rentables{dummy_field: false};
        0x2::kiosk_extension::add<Rentables>(v0, arg0, arg1, 3, arg2);
    }

    public fun mint(arg0: u8, arg1: &mut Inventory, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == @0x554a2392980b0c3e4111c9a0e8897e632d41847d04cbd41f9e081e49ba2eb04a || v0 == @0x9e7aaf5f56ae094eadf9ca7f2856f533bcbf12fcc9bb9578e43ca770599a5dce, 6);
        assert!(arg0 >= 1 && arg0 <= 31, 1);
        assert!(arg1.count < 100000000, 2);
        arg1.count = arg1.count + 1;
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Green"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Black"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Blue"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Dark"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Dragon"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Dragoniux"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Earth"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Electric"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Electriux"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Fire"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Ice"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Ice Shadow"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Orange"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Pink"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Plant"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Plant Shadow"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Sky"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Violet"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Wind"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Wind Storm"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Exrix Yellow"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Minidragon Dark"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Minidragon Electric"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Minidragon Epic"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Minidragon Exrix"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Minidragon Fire"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Minidragon Ice"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Minidragon Plant"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Minidragon Earth"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Minidragon Aqua"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Minidragon Wind"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmXXDUZr8Xbh6xq4KgGV14RrLECFZCySzhgTeZJUxejd1f"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmcSDjkLjEwpnuQd6Dgms2sMme4rep63FvorCRAkFrDbZU"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Qmc1bnDz3VVnpBrKe6jT1VQCSr5DHkzt6WFFSbk5Ko7AbM"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmVF7EHKiX4zZwuZfZ3SkNns9kkApigSsakyEJLxjxYDgW"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmRtBp6XmsXwKFwyCeHVRRMUugXs1UxuBiMMoypPkXRoHt"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmXjR3sgBEA4nQQm1xwUPcmqz8bqrYBqqc8xD6ZWi9tWpw"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmdZeXXxgXiBovKhQnmzZTRjvwA6qQNg3CfUnWzd7JMNks"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Qmd5g4eS7qPV8gaWSESsLAwTw5dCLWgWsSkJL8pApP3nCP"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmUy9LmB9jzftNyVy75oD3AhFwYwbdrBY8qr7AsUWX5Kvu"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmPrcRqcfKU7c2WQKt5SHga7Nmy7M9QVs1hYfxCwA7ZWWk"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmRaFm2jgXbMGcRkrrpzH7opJ17DWdiouhtJGCNaKqPH1L"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmQ1GW7w7Z979JQZm4F8ibSDtpMhWeGLDp3tAN3Sv12j6U"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmZvkKNqnQuV6AWbKeSAKxyGuX8WjRoMuh3DNDBWwWEzqu"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmSqPuxFoJkgPiW24bqaYzdK13Srsd4YsR4JBKxjEKsiTW"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmQEe3V3SGKvfqjJ4qWGBzTcayznZj1BsTGzvzMMYpntRa"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmPgjiD9g8arZcnn2aZV4tDa5N6wrS1ZLfGysvkkUEzKMW"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmPWFNbjptqLKXeN92mFQM67jS8JYMjve1vXQU5jQHhmbp"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmSEHcbqFZiNPKCnnqvkh42Vkca3tSv13Vo7HMEHtRrzXm"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmcTwAbGhHTuUfiStMtFh2nmBAHfUsmadT2cDDAUcJyasU"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmWXDL6K3UdtKSCevhev2nLjAR31eEQNJ2XrCBqqi77P8U"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmTzPLVqktDZSTKYqr2JCFQ9PU7RpPB7FRyx1Jrqu56KDJ"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmbmtFtgBRrK6odExW3ypVWjxrq1FYb4eBwNkxtFVQ1Cxc"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmP8MKizGdcvnFf4WpGGQNt1tCoczwnyynGG5pnXDyGfWw"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmV8NFVAWgLf8u2eV37HdtGsNk8AkHNnyT97kagDE62mrT"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmSUnf46fRJfEiUVvKAJ5RcZVyyktF48Kez1mFuHyu8bkZ"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmZo15T11teNCL5obQiijmbkdFNu9mJcpuuQAn7XAKY8sT"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Qmd2eJuXsTbUbKaEWFSH95BYDWvMAPcz1VoWiRtmiRumsG"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmTvS455pby3iy94noTzh66azouC41xFDCZP2uHirSBRew"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmcwaCjSw8FphxERDbwsJeLjrcKat6RTNyriZzX2pCpNcE"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmX5hCAhCVuX9awLqcY6QfySVSet6FBxsagpsLYfGyysXM"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"QmQTS9ihjF5sfeQfZpvfsKQhMmBYg6QoVq5xAZ3m7o2aMu"));
        let v5 = *0x1::vector::borrow<0x1::string::String>(&v1, (arg0 as u64) - 1);
        let v6 = 0x1::string::utf8(b"https://ipfs.io/ipfs/");
        0x1::string::append(&mut v6, *0x1::vector::borrow<0x1::string::String>(&v3, (arg0 as u64) - 1));
        let (v7, v8, v9, v10) = get_stats_for_type(arg0);
        let v11 = Jablix{
            id       : 0x2::object::new(arg2),
            name     : v5,
            url      : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v6)),
            hp       : v7,
            speed    : v8,
            energy   : v9,
            strength : v10,
        };
        let v12 = 0x2::tx_context::sender(arg2);
        let v13 = JablixMinted{
            object_id      : 0x2::object::id<Jablix>(&v11),
            owner          : v12,
            type_id        : arg0,
            name           : v5,
            current_supply : arg1.count,
            price_paid     : 0,
        };
        0x2::event::emit<JablixMinted>(v13);
        0x2::transfer::public_transfer<Jablix>(v11, v12);
    }

    public fun name(arg0: &Jablix) : &0x1::string::String {
        &arg0.name
    }

    public fun rent(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut RentalPolicy, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk_extension::is_installed<Rentables>(arg1), 0);
        let v0 = Rentables{dummy_field: false};
        let v1 = Listed{id: arg3};
        let v2 = 0x2::bag::remove<Listed, Rentable>(0x2::kiosk_extension::storage_mut<Rentables>(v0, arg0), v1);
        assert!(v2.price_per_day <= 18446744073709551615 / v2.duration, 2);
        let v3 = v2.price_per_day * v2.duration;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == v3, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, (((v3 as u128) * (arg2.amount_bp as u128) / (10000 as u128)) as u64), arg6)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, 0x2::tx_context::sender(arg6));
        v2.start_date = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg5));
        let v4 = Rentables{dummy_field: false};
        let v5 = Rented{id: arg3};
        0x2::bag::add<Rented, Rentable>(0x2::kiosk_extension::storage_mut<Rentables>(v4, arg1), v5, v2);
    }

    public fun speed(arg0: &Jablix) : u64 {
        arg0.speed
    }

    public fun strength(arg0: &Jablix) : u64 {
        arg0.strength
    }

    public fun supply(arg0: &Inventory) : u64 {
        arg0.count
    }

    public fun update_display_field(arg0: &mut 0x2::display::Display<Jablix>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x9e7aaf5f56ae094eadf9ca7f2856f533bcbf12fcc9bb9578e43ca770599a5dce, 6);
        0x2::display::edit<Jablix>(arg0, arg1, arg2);
        0x2::display::update_version<Jablix>(arg0);
    }

    // decompiled from Move bytecode v6
}

