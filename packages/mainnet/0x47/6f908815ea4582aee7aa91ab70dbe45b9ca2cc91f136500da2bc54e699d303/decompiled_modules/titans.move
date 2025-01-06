module 0x476f908815ea4582aee7aa91ab70dbe45b9ca2cc91f136500da2bc54e699d303::titans {
    struct TITANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITANS>(arg0, 6, b"TITANS", b"TITANS OF SUI", b"Titans of SUI | Armored in strength, united in vision. Defenders of innovation and builders of a new meme meta", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tit_d68541bb97_44cbe2b039.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITANS>>(v1);
    }

    // decompiled from Move bytecode v6
}

