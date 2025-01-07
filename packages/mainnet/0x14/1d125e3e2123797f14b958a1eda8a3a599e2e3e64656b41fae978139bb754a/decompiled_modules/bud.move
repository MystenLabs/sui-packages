module 0x141d125e3e2123797f14b958a1eda8a3a599e2e3e64656b41fae978139bb754a::bud {
    struct BUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUD>(arg0, 6, b"BUD", b"Big Bud", x"496e204d6174742046757269657320626f6f6b2c20426f797320436c75622c204269672042756420697320612063686172616374657220696e2074686520636f6d6963207365726965732e2042696720427564206973206f6e65206f6620746865736520636861726163746572732c20636861726163746572697a656420627920686973206c6169642d6261636b2c20736f6d65776861742073746f6e65722d6c696b6520706572736f6e616c6974790a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/opp_EY_07_O_400x400_1b3e7515cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

