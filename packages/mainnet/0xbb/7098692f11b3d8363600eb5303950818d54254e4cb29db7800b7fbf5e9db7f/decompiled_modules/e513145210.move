module 0xbb7098692f11b3d8363600eb5303950818d54254e4cb29db7800b7fbf5e9db7f::e513145210 {
    struct E513145210 has drop {
        dummy_field: bool,
    }

    fun init(arg0: E513145210, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<E513145210>(arg0, 9, b"E513145210", b"Qqq", b"Handsomeboy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7544ec0f-e091-4563-bd49-047f79a3ab8f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<E513145210>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<E513145210>>(v1);
    }

    // decompiled from Move bytecode v6
}

