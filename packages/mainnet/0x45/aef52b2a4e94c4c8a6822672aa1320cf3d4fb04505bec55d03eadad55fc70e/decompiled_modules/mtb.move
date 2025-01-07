module 0x45aef52b2a4e94c4c8a6822672aa1320cf3d4fb04505bec55d03eadad55fc70e::mtb {
    struct MTB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTB>(arg0, 9, b"MTB", b"MINE ", b"New generation token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b412818-9bc5-4b6b-89e5-738f00baa069.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTB>>(v1);
    }

    // decompiled from Move bytecode v6
}

