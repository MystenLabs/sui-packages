module 0x2506b95635605afe8e0d2bdd86a36d55162a7512474d0208bd98c3d2ef50c026::catbull {
    struct CATBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATBULL>(arg0, 9, b"CATBULL", b"Cat the bu", b"Bullrun cat.. up only", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0bb8cdc4-03fc-415d-a6ba-af3477c5205e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

