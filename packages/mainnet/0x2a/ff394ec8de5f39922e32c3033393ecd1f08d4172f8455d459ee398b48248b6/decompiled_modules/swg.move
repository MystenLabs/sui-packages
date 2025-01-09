module 0x2aff394ec8de5f39922e32c3033393ecd1f08d4172f8455d459ee398b48248b6::swg {
    struct SWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWG>(arg0, 9, b"SWG", b"suiwin ghost", b"I am the ghost of SUIWINgame, a memecoin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c8c4999ed39e737ac7bea5b884db09adblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

