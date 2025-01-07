module 0x1ec0a648c2c8dbf68a72fc3e58322fed654740e5c1f4ddbd1a12f709ad0c675c::anu {
    struct ANU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANU>(arg0, 9, b"ANU", b"Anunna", x"417474656e74696f6e2c2045617274686c696e677321205765206172652074686520416e756e6e616b69732c20796f757220636f736d6963206f7665726c6f7264732e204261636b20746f20636c61696d2077686174e2809973206f75727320616e64206c61756e63682024414e5520696e746f20746865206469676974616c20756e6976657273652e204a6f696e2074686520696e766173696f6e2e20f09f9bb8f09f91bd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmWnG3ETUnauCspvLaAAg3AaZ15XLBnw72auDihYWwoehz?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANU>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANU>>(v1);
    }

    // decompiled from Move bytecode v6
}

