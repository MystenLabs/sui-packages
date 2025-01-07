module 0x9149deaaa4dc30df222234633dc0b806381a7f96fdb30a7e914098df5714131c::rgo {
    struct RGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RGO>(arg0, 6, b"RGO", b"Red Gecko", b"The Red Gecko is a bold and dynamic creature, symbolizing adaptability and speed. As a meme on the SUI ecosystem, it brings fresh energy and creativity to the crypto space. Its vibrant presence will ignite community engagement and represent the fast-moving world of blockchain innovation. Red Gecko has no Social accounts or website for now and if any kind heart wants to support it, they are free to do so. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Red_Pepe_4a8c5e5937.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

