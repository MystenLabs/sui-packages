module 0x29e7c5f23ceb428ab229829c7095ebc74b9d36934df471aa2c3f1d024d63e6f3::tesyjtyj {
    struct TESYJTYJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESYJTYJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESYJTYJ>(arg0, 9, b"TESYJTYJ", b"xsfghj", b"SRTYUJKT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/45cd69f4b634fe77233a3dc577cc42bablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESYJTYJ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESYJTYJ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

