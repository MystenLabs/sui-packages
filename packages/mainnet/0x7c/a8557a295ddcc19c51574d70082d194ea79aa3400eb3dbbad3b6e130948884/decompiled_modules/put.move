module 0x7ca8557a295ddcc19c51574d70082d194ea79aa3400eb3dbbad3b6e130948884::put {
    struct PUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUT>(arg0, 9, b"PUT", b"Karlito", b"Misia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2943ba77-aa7b-44dd-a59e-9c1757bcff94.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

