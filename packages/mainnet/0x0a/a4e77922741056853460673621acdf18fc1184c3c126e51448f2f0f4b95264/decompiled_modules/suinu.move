module 0xaa4e77922741056853460673621acdf18fc1184c3c126e51448f2f0f4b95264::suinu {
    struct SUINU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUINU>, arg1: 0x2::coin::Coin<SUINU>) {
        0x2::coin::burn<SUINU>(arg0, arg1);
    }

    fun init(arg0: SUINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINU>(arg0, 9, b"suinu", b"suinu", b"suinu the sui chain mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/Uq1LxOJ.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINU>>(v1);
        0x2::coin::mint_and_transfer<SUINU>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINU>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUINU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUINU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

