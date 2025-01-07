module 0xb7a15e56d999276bf0220899206a0a1bf3cb89ec2ed4875eb785cae6cec49eb::scf {
    struct SCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCF>(arg0, 6, b"SCF", b"Smoking Chicken Fish", b"Why choose between land and sea when you can be both? The Smoking Chicken Fish is redefining existence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_9c_Mcg_W8_AA_Geq_K_c932af06dd.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

