module 0x49e97e64622bc96312c5326457bee33197e09066fcbfcc65f615db698d365b7f::pompeii {
    struct POMPEII has drop {
        dummy_field: bool,
    }

    fun init(arg0: POMPEII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POMPEII>(arg0, 6, b"POMPEII", b"PumpPeii", b"The Eruption of Mount Vesuvius in 79 AD that destroyed the city of Pompeii, now on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/channels4_profile_19a389d616.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POMPEII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POMPEII>>(v1);
    }

    // decompiled from Move bytecode v6
}

