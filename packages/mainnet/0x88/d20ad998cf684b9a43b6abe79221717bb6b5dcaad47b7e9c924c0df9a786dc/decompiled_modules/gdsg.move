module 0x88d20ad998cf684b9a43b6abe79221717bb6b5dcaad47b7e9c924c0df9a786dc::gdsg {
    struct GDSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDSG>(arg0, 9, b"GDSG", b"SDGDSA", b"GVSSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cde9adde-0c57-41e8-b5f5-1ebf08233d12.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

