module 0x82636ee89cf546522a3ef9e001fe57dec18f061f9e9e5595ed3db3c28e19ffc6::t {
    struct T has drop {
        dummy_field: bool,
    }

    fun init(arg0: T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T>(arg0, 9, b"T", b"TROUT", b"meme TROUT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e813f228-bbcd-4866-96ec-5e3d7632b6bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T>>(v1);
    }

    // decompiled from Move bytecode v6
}

