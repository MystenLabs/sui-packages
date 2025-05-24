module 0x48beea7a79058b00de1c94e76daa87162bece605b32ec7c5f9d2b44e021b7f6d::lc {
    struct LC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LC>(arg0, 9, b"LC", b" Liquidity Cipher", b"Liquidity Cipher is a  character forged from liquid energy and digital wealth, embodying the fusion of finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/edf66282e176b376a8d64cc93c18f2cfblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

