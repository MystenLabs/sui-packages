module 0xb26d4e1b944d2f382f7fb15dfa7d997e090855eb2b14523d368a90ec8ab1ea54::rec {
    struct REC has drop {
        dummy_field: bool,
    }

    fun init(arg0: REC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REC>(arg0, 9, b"REC", b"Remember ", b"The only way you will ever ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4bf4ffd0-3705-43a9-9659-dce34628d61c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REC>>(v1);
    }

    // decompiled from Move bytecode v6
}

