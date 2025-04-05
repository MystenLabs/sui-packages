module 0xa9599f916733627e1662217e22e9303a9f97bc529cdccfb04d5d96f75a9eb26b::trn {
    struct TRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRN>(arg0, 9, b"TRN", b"Tron", b"Tron nft", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ffa60170878d0e3bec2574672b71cdb4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

