module 0x14817e344d43b395a66856a224e2974ba55680af9d6a4313ad9cc0b43ea00244::xiao {
    struct XIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIAO>(arg0, 6, b"XIAO", b"XIAO SUI", b"XIAO  meme on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/727ee352c3a7a0447fde0caa1e8a9dcd_644fe4a141.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

