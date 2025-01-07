module 0xb9376a9abde090dc16308f1f43975723e483d04cd32b7bd1c357015f72bf9021::jeetolax {
    struct JEETOLAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEETOLAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEETOLAX>(arg0, 6, b"JEETOLAX", b"Jeetolaxsui", b"Jeetolax is a meme coin on the sui. A parody  of meme goodness aiming to fix the issue of Jeeting that any Crypto project experiences. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o_Ija_Di_J_400x400_9890ca6ae7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEETOLAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEETOLAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

