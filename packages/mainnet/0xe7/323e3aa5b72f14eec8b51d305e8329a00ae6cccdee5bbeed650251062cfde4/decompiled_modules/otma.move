module 0xe7323e3aa5b72f14eec8b51d305e8329a00ae6cccdee5bbeed650251062cfde4::otma {
    struct OTMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTMA>(arg0, 9, b"OTMA", b"Otmanabuba", b"OTMA token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f40cbfdf-8668-4c35-967c-25dfac0540af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

