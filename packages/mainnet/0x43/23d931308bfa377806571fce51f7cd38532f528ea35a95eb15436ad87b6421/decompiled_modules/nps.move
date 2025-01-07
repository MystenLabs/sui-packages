module 0x4323d931308bfa377806571fce51f7cd38532f528ea35a95eb15436ad87b6421::nps {
    struct NPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPS>(arg0, 6, b"NPS", b"Aibull wif Nail-Patella Syndrome", b"In summary, Nail-Patella Syndrome is a complex disorder resulting from mutations in the LMX1B gene, leading to various physical and health-related challenges. The Aibull project highlights the personal impact of genetic conditions and demonstrates the potential for advocacy through innovative platforms like cryptocurrency. Through this endeavor, we hope to foster awareness and support for individuals living with NPS and similar genetic disorders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Projekt_bez_nazwy_05ff85bcfd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

