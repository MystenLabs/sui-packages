module 0xd4f908f8b483ded67dd8c6da203ee492188ade6ab6a17a79ccf3b39307e90025::aibot {
    struct AIBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIBOT>(arg0, 6, b"Aibot", b"Goatseus Maximus", b"goatseus maximus is a spiritual successor to goatse. it's the same hermetic, Gnostic, and Catharist themes but for the age of AI. it's about the goatse of things, the void that gives birth to all things and into which all things are returned.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AQI_Upf_L3_400x400_215ae90452.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

