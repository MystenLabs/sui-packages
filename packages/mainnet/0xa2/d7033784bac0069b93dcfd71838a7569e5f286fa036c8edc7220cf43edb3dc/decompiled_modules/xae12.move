module 0xa2d7033784bac0069b93dcfd71838a7569e5f286fa036c8edc7220cf43edb3dc::xae12 {
    struct XAE12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAE12, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAE12>(arg0, 6, b"XAE12", x"5820c38620412d3132", b"They laughed at the name. That's because they didn't understand Elon had birthed the very first human coin through a fusion of technologies such as Uterus, Neuralink and a yield generating strategy known as 'cracking'. Now Elon wants you to crack too", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1755368857113.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XAE12>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAE12>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

