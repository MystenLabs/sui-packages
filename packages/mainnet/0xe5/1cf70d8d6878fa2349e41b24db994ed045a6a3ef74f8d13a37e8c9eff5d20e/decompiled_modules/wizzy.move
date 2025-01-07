module 0xe51cf70d8d6878fa2349e41b24db994ed045a6a3ef74f8d13a37e8c9eff5d20e::wizzy {
    struct WIZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIZZY>(arg0, 6, b"WIZZY", b"THE WIZARD BEAR", b"in the mystical realm, a powerful Wizard Bear named WIZZY roamed the ancient forests. With eyes aglow like embers, WIZZY wielded the magic of the land, summoning the whispers of the trees and the roar of the rivers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_24_7_01_34a_PM_b1d61c4736.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

