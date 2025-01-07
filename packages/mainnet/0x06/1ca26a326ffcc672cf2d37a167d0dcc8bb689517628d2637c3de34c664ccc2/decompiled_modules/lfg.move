module 0x61ca26a326ffcc672cf2d37a167d0dcc8bb689517628d2637c3de34c664ccc2::lfg {
    struct LFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LFG>(arg0, 9, b"LFG", b"LFG", b"The official hype coin for Sui! LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://drive.google.com/file/d/1JmkvDfkSdd214VHjXZs5FR5NOJQL5Q7p/view?usp=sharing")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LFG>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LFG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

