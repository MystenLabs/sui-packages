module 0xc3c41e8d0aea2df88da1aad5577219a5ec955dc8d28eed897bac0ab1c5406960::dago {
    struct DAGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAGO>(arg0, 9, b"DAGO", b"DAGOBERT DUCK", x"496e206120776f726c64206f6620626f72696e672063727970746f732c20244441474f206973206d616b696e6720612073706c6173682120f09fa686f09f8c8a20496e737069726564206279204461676f62657274204475636b2c206974e28099732074696d6520746f2067657420736572696f75732061626f75742066756e20616e64207765616c74682e202343727970746f4c696665", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/cms/images/BtWqbweRH8X3yUMv?width=400&height=400&fit=crop&quality=95&format=auto")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DAGO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAGO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

