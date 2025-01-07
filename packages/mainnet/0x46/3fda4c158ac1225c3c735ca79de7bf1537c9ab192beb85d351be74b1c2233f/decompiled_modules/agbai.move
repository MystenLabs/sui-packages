module 0x463fda4c158ac1225c3c735ca79de7bf1537c9ab192beb85d351be74b1c2233f::agbai {
    struct AGBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGBAI>(arg0, 9, b"AGBAI", b"AG", b"Agbai is an ordinary boy born in the trenches but aims and fights to be the richest and the greatest man ever liveth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3473de7c-429d-49bd-a62d-17a651256615.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGBAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGBAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

