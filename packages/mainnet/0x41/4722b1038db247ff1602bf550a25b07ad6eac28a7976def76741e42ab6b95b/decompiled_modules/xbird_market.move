module 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xbird_market {
    struct XBIRD_MARKET has drop {
        dummy_field: bool,
    }

    struct Market has store, key {
        id: 0x2::object::UID,
        nft_type: 0x1::type_name::TypeName,
        token_type: 0x1::type_name::TypeName,
        rays: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        total: u16,
    }

    struct MarketCreated has copy, drop, store {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        nft_type: 0x1::type_name::TypeName,
        token_type: 0x1::type_name::TypeName,
    }

    struct RayCreated has copy, drop, store {
        market: 0x2::object::ID,
        kiosk: 0x2::object::ID,
        vault: 0x2::object::ID,
    }

    public fun list<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::KioskVault, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::list<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun place<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::KioskVault, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::place<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun placeAndList<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::KioskVault, arg2: T0, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::placeAndList<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun addRay<T0: store + key, T1>(arg0: &0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::PKAdminCap, arg1: &mut Market, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::get<T0>() == arg1.nft_type && 0x1::type_name::get<T1>() == arg1.token_type, 5001);
        let (v0, v1) = 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::createPublicKiosk<T0, T1>(arg0, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::object::id<0x2::kiosk::Kiosk>(&v3);
        let v5 = 0x2::object::id<0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::KioskVault>(&v2);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg1.rays, v4, v5);
        arg1.total = arg1.total + 1;
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_share_object<0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::KioskVault>(v2);
        let v6 = RayCreated{
            market : 0x2::object::id<Market>(arg1),
            kiosk  : v4,
            vault  : v5,
        };
        0x2::event::emit<RayCreated>(v6);
    }

    public fun createMarket<T0: store + key, T1>(arg0: &0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::PKAdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = Market{
            id         : 0x2::object::new(arg2),
            nft_type   : v0,
            token_type : v1,
            rays       : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg2),
            total      : 0,
        };
        let v3 = MarketCreated{
            id         : 0x2::object::id<Market>(&v2),
            name       : 0x1::string::utf8(arg1),
            nft_type   : v0,
            token_type : v1,
        };
        0x2::event::emit<MarketCreated>(v3);
        0x2::transfer::public_share_object<Market>(v2);
    }

    fun init(arg0: XBIRD_MARKET, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun purchaseByCoin<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::KioskVault, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::transfer_policy::TransferPolicy<0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xnft::XNft>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::purchase<0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xnft::XNft, 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xbird::XBIRD>(arg0, arg1, arg2, arg5);
        let v3 = v2;
        let v4 = v1;
        0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xnft::payByCoin<T0>(&mut v4, &v3, arg3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xnft::XNft>(arg4, v4);
        0x2::transfer::public_transfer<0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xnft::XNft>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun purchaseByXBird(arg0: &mut 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xbird::BirdPegVault, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::KioskVault, arg3: 0x2::object::ID, arg4: 0x2::token::Token<0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xbird::XBIRD>, arg5: &mut 0x2::transfer_policy::TransferPolicy<0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xnft::XNft>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::purchase<0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xnft::XNft, 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xbird::XBIRD>(arg1, arg2, arg3, arg6);
        let v3 = v2;
        let v4 = v1;
        0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xnft::payByXBird(arg0, &mut v4, &v3, arg4, arg6);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xnft::XNft>(arg5, v4);
        0x2::transfer::public_transfer<0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::xnft::XNft>(v0, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

