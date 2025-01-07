module 0x6c9f136c6f4d52bea38871171c641ed500544caff495e2ec4066a6555d45b8b2::wj {
    struct WJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WJ>(arg0, 6, b"WJ", b"Wet January", x"57656c636f6d6520746f202a2a576574204a616e756172792a2a20e2809320746865206d656d6520636f696e20746861742773206865726520746f206472656e636820796f757220647279207370656c6c21205768696c65207468652072657374206f662074686520776f726c642069732073697070696e67206f6e20746865697220677265656e207465617320616e6420737061726b6c696e67207761746572732c207765277265206865726520746f206d616b65204a616e7561727920746865206472756e6b657374206d6f6e7468206f662074686520796561722120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735932411120.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WJ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WJ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

