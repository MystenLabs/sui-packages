module 0x2a9eb4e90f5d9d451eaab6219d360434242f624fb608580a69eb40cf5f45d441::suinu {
    struct SUINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINU>(arg0, 9, b"SUINU", b"Suinu", b"pirate dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUINU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINU>>(v2, @0x38368440df68ee26318ad94526d750b685dacfad362cee5dac63432126d78800);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

