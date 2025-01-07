module 0xdd23fd6fa2a33466ac70b1a5ac71c6049f798e936382e8fddcaa73539cf71ac6::bud {
    struct BUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUD>(arg0, 6, b"Bud", b"BudSui", x"496e204d617474204675726965277320626f6f6b2c20426f79277320436c75622c204269672042756420697320612063686172616374657220696e2074686520636f6d6963207365726965732e2042696720427564206973206f6e65206f6620746865736520636861726163746572732c20636861726163746572697a656420627920686973206c6169642d6261636b2c20736f6d65776861742073746f6e65722d6c696b6520706572736f6e616c6974790a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_30347d9ba1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

