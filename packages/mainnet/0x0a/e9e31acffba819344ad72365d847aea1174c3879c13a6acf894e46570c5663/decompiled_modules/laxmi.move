module 0xae9e31acffba819344ad72365d847aea1174c3879c13a6acf894e46570c5663::laxmi {
    struct LAXMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAXMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAXMI>(arg0, 9, b"LAXMI", b"PROJECT LAXMI", b"GOD OF WEALTH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/08c81c45cbb0274bc310078b5ed46096blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAXMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAXMI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

