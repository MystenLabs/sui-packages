module 0x66fc8e1e37242d8454db125a89290fa06f1fd0602c66cb16601edb05a9122e77::sponge {
    struct SPONGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONGE>(arg0, 9, b"SPONGE", b"Sponge on Sui", b"We're $SPONGE, We're all vibing!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/83ce99023f9c146cb043f9ae501dd18eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPONGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

