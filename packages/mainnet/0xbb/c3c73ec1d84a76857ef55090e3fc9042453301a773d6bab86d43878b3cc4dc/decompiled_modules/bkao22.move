module 0xbbc3c73ec1d84a76857ef55090e3fc9042453301a773d6bab86d43878b3cc4dc::bkao22 {
    struct BKAO22 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKAO22, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKAO22>(arg0, 9, b"BKAO22", b"bocao22coin", b"bocao coin colmeia web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1cae5202dafeb8b296179225deb029b7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BKAO22>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKAO22>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

