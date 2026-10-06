module 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::crown {
    struct CrownSeed has store, key {
        id: 0x2::object::UID,
        epoch: u64,
        rank: u64,
        tier: u8,
        palette_id: u8,
        no: u64,
        prize: 0x2::balance::Balance<0x2::sui::SUI>,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun value(arg0: &CrownSeed) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize)
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u8, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : CrownSeed {
        let v0 = palette_of(arg0);
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"Epoch"), 0x1::u64::to_string(arg0));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"Rank"), 0x1::u64::to_string(arg1));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"Tier"), 0x1::u64::to_string((arg2 as u64) + 1));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"Title"), title_of(arg2));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"Palette"), palette_name(v0));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"Prize"), sui_label(0x2::balance::value<0x2::sui::SUI>(&arg3)));
        CrownSeed{
            id         : 0x2::object::new(arg4),
            epoch      : arg0,
            rank       : arg1,
            tier       : arg2,
            palette_id : v0,
            no         : arg0 * 1000 + arg1,
            prize      : arg3,
            attributes : v1,
        }
    }

    public fun attributes(arg0: &CrownSeed) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun epoch(arg0: &CrownSeed) : u64 {
        arg0.epoch
    }

    public fun no(arg0: &CrownSeed) : u64 {
        arg0.no
    }

    public fun palette_id(arg0: &CrownSeed) : u8 {
        arg0.palette_id
    }

    fun palette_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Emerald")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Ruby")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Sapphire")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Amber")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Aqua")
        } else {
            0x1::string::utf8(b"Amethyst")
        }
    }

    fun palette_of(arg0: u64) : u8 {
        (((arg0 % 6 + 6 - 1) % 6) as u8)
    }

    public fun rank(arg0: &CrownSeed) : u64 {
        arg0.rank
    }

    public fun setup_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<CrownSeed> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"prize_mist"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Crown Seed #{no}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A Crown Seed holds the SUI prize of one weekly Standing. Burn it to unseal."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://hashbonsai-assets.wal.app/seeds/seed_tire{tier}_c{palette_id}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://hashbonsai.wal.app"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{prize.value}"));
        let v4 = 0x2::display::new_with_fields<CrownSeed>(arg0, v0, v2, arg1);
        0x2::display::update_version<CrownSeed>(&mut v4);
        v4
    }

    public fun setup_royalty(arg0: &0x2::package::Publisher, arg1: u16, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferPolicyCap<CrownSeed> {
        let (v0, v1) = 0x2::transfer_policy::new<CrownSeed>(arg0, arg3);
        let v2 = v1;
        let v3 = v0;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<CrownSeed>(&mut v3, &v2, arg1, arg2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<CrownSeed>>(v3);
        v2
    }

    fun sui_label(arg0: u64) : 0x1::string::String {
        let v0 = arg0 % 1000000000 / 1000000;
        let v1 = 0x1::u64::to_string(arg0 / 1000000000);
        0x1::string::append_utf8(&mut v1, b".");
        if (v0 < 100) {
            0x1::string::append_utf8(&mut v1, b"0");
        };
        if (v0 < 10) {
            0x1::string::append_utf8(&mut v1, b"0");
        };
        0x1::string::append(&mut v1, 0x1::u64::to_string(v0));
        0x1::string::append_utf8(&mut v1, b" SUI");
        v1
    }

    public fun tier(arg0: &CrownSeed) : u8 {
        arg0.tier
    }

    fun title_of(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Apex")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Podium")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Elite")
        } else {
            0x1::string::utf8(b"Contender")
        }
    }

    public(friend) fun unseal(arg0: CrownSeed) : (u64, u64, 0x2::balance::Balance<0x2::sui::SUI>) {
        let CrownSeed {
            id         : v0,
            epoch      : v1,
            rank       : v2,
            tier       : _,
            palette_id : _,
            no         : _,
            prize      : v6,
            attributes : _,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2, v6)
    }

    // decompiled from Move bytecode v7
}

