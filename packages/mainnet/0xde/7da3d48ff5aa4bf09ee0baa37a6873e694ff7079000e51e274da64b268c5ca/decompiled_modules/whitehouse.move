module 0xde7da3d48ff5aa4bf09ee0baa37a6873e694ff7079000e51e274da64b268c5ca::whitehouse {
    struct WHITEHOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHITEHOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHITEHOUSE>(arg0, 6, b"WHITEHOUSE", b"The White House", b"The White House is where the President and First Family of the United States live and work  but its also the Peoples House, where we hope all Americans feel a sense of inclusion and belonging. Now on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/White_House_23339bbe86.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHITEHOUSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHITEHOUSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

