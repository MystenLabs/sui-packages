module 0xf7f983b9d1ef00745620ad85a177f83daf9673bd7a096feea5875d69e3255088::tsui {
    struct TSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUI>(arg0, 6, b"tSUI", b"teachSUI", b"teachSUI is just a chill teacher who likes to talk about SUI with his chill students. chill teacher cares greatly about the future of his chill students. wenn chill students do well in class, chill teacher rewards them with tSUI. wenn chill students earn a lot tSUI, chill students redeem tSUI in exchange for SUI and this creates incentive for chill students to learn and remain chill in class. wenn will you embrace the teachSUI ecosystem in your class? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/editthis_in_paint_editedversion_edited_lastedit_jped_ea255cee0f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

