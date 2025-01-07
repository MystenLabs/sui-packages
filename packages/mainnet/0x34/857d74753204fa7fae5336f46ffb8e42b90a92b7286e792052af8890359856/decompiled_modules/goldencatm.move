module 0x34857d74753204fa7fae5336f46ffb8e42b90a92b7286e792052af8890359856::goldencatm {
    struct GOLDENCATM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDENCATM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDENCATM>(arg0, 9, b"GOLDENCATM", b"Catm", b"Hey guys follow me and buy my token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6ae558ad-6000-4c1c-977d-9e00ef8035a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDENCATM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLDENCATM>>(v1);
    }

    // decompiled from Move bytecode v6
}

