module 0x6bead0e2905fa971f45849b9e3b8c7f7c01e73a5df7dc1f8ad76a63bf84dff8::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::BondingCurveStartCap<PUMP>>(0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::create_bonding_curve<PUMP>(arg0, b"PUMP", b"pump ", b"pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-image.tucanadev.net/icon/cf1dafa2-34ff-42f8-8f90-72117cafda25_cetus_pump_1732156848.png")), b"", b"", b"", b"", 0x1::string::utf8(b"0022bb48db80cb3f527617ba184006c7fb36af84dd580857f7674442250b9c542e173a09caf1e4c18ced082afd1260d380e65cac303fc3cff6c9d76c9a0bdf220a2b29e6d9d2f97b81d63bdea83da70b8c1ba172cabaeef1786acbe6c04a2125da"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

