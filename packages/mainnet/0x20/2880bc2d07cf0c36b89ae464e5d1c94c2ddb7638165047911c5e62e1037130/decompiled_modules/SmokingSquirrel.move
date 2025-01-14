module 0x202880bc2d07cf0c36b89ae464e5d1c94c2ddb7638165047911c5e62e1037130::SmokingSquirrel {
    struct SMOKINGSQUIRREL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOKINGSQUIRREL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOKINGSQUIRREL>(arg0, 6, b"SmokingSquirrel", b"SMOKINGSQUIRREL", b"A cinematic masterpiece of questionable rodent life choices, viewed through the warped perspective of a fisheye lens. Proof that even squirrels have bad habitsand zero regard for forest fire safety.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmdX1PtRntLtna9B2NqXvCSnPrdcgStxrPtge8oBEZAUtS")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOKINGSQUIRREL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOKINGSQUIRREL>>(v1);
    }

    // decompiled from Move bytecode v6
}

