module 0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi {
    struct OSHI has drop {
        dummy_field: bool,
    }

    struct ControlledTreasuryCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ControlledTreasury has store, key {
        id: 0x2::object::UID,
        limit: u64,
    }

    struct CoinMetadataKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OshiCoinMetadata has store, key {
        id: 0x2::object::UID,
    }

    struct OshiMinted has copy, drop {
        coin_id: 0x2::object::ID,
        amount: u64,
        minted_by: address,
        recipient: address,
    }

    public entry fun burn(arg0: &ControlledTreasuryCap, arg1: &mut ControlledTreasury, arg2: 0x2::coin::Coin<OSHI>) {
        0x2::coin::burn<OSHI>(borrow_mut_treasury_cap(arg1), arg2);
    }

    public fun mint(arg0: &ControlledTreasuryCap, arg1: &mut ControlledTreasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 9223372427696865282);
        assert!(0x2::coin::total_supply<OSHI>(borrow_treasury_cap(arg1)) + arg2 <= arg1.limit, 9223372444876865540);
        let v0 = 0x2::coin::mint<OSHI>(borrow_mut_treasury_cap(arg1), arg2, arg4);
        let v1 = OshiMinted{
            coin_id   : 0x2::object::id<0x2::coin::Coin<OSHI>>(&v0),
            amount    : arg2,
            minted_by : 0x2::tx_context::sender(arg4),
            recipient : arg3,
        };
        0x2::event::emit<OshiMinted>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<OSHI>>(v0, arg3);
    }

    fun borrow_mut_treasury_cap(arg0: &mut ControlledTreasury) : &mut 0x2::coin::TreasuryCap<OSHI> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<OSHI>>(&mut arg0.id, v0)
    }

    fun borrow_treasury_cap(arg0: &ControlledTreasury) : &0x2::coin::TreasuryCap<OSHI> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<OSHI>>(&arg0.id, v0)
    }

    fun init(arg0: OSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSHI>(arg0, 9, b"OSHI", b"OSHI Token", x"496e2074686520706173742c20676f7665726e616e636520746f6b656e7320696e20626c6f636b636861696e20656e7465727461696e6d656e742070726f6a656374732068617665206f6674656e2072656c69656420736f6c656c79206f6e207468652076616c7565206f66207468652073696e676c6520636f6e74656e742c20726573756c74696e6720696e206d616e7920746f6b656e73206265696e6720756e61626c6520746f206d61696e7461696e206c6f6e672d7465726d2073746162696c69747920616e64206c656164696e6720746f20707269636520636f6c6c61707365732e204f5348492061696d7320746f206275696c642075706f6e20636f6e74656e74732064657369676e656420666f72206c6f6e672d7465726d206f7065726174696f6e2c207768696c6520616c736f20616c69676e696e6720697473207574696c6974792028746f6b656e207573652063617365732920616e6420756e6465726c79696e672076616c7565206f6e20686967682d76616c756520495073206b6e6f776e20666f72207468656972207375737461696e6162696c6974792e205468652061696d20697320746f2061636869657665206c6f6e672d7465726d2073746162696c697479206f66206974732076616c75652e2054686572652061726520616c736f20706c616e7320696e20706c61636520746f2064657369676e20616e2065636f73797374656d207468617420616c6c6f77732074686520746f6b656e2065636f6e6f6d7920746f207370616e206163726f7373206d756c7469706c65207479706573206f6620636f6e74656e7420696e20746865206675747572652e20546865206e616d6520e2809c4f534849e2809d207761732063686f73656e20746f207265666c656374207468652064657369726520666f72207573657273202866616e732920746f20656e6a6f79207468652067616d6520696e20746865206c6f6e67207465726d20616e6420656e6761676520696e20746865204a6170616e65736520636f6e6365707420e2809c4f736869204b61747375e2809d2028737570706f7274696e67207468656972206661766f72697465206368617261637465727329207669612074686520746f6b656e732077697468207065616365206f66206d696e642e204f5348492069732072756e2062792067756d692e696e632c2061204a6170616e6573652d6c697374656420636f6d70616e79207370656369616c697a696e6720696e206d6f62696c652067616d696e6720616e6420626c6f636b636861696e20736f6c7574696f6e73206163726f737320656e7465727461696e6d656e7420616e642066696e616e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/OlHnBnAbU5fQtgu9I4z_0OBninKjDwfIxiLzJVuxMYQ")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<OSHI>>(0x2::coin::mint<OSHI>(&mut v2, 510000000000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = ControlledTreasuryCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<ControlledTreasuryCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = OshiCoinMetadata{id: 0x2::object::new(arg1)};
        let v5 = CoinMetadataKey{dummy_field: false};
        0x2::dynamic_object_field::add<CoinMetadataKey, 0x2::coin::CoinMetadata<OSHI>>(&mut v4.id, v5, v1);
        0x2::transfer::share_object<OshiCoinMetadata>(v4);
        let v6 = ControlledTreasury{
            id    : 0x2::object::new(arg1),
            limit : 510000000000000000,
        };
        let v7 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<OSHI>>(&mut v6.id, v7, v2);
        0x2::transfer::share_object<ControlledTreasury>(v6);
    }

    // decompiled from Move bytecode v6
}

