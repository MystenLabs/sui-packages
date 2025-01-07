module 0x2ced8969b46ff8fc6e7f3d2587e974df372f018ed9625c2f83dc533df03ee9f2::maba {
    struct MABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MABA>(arg0, 6, b"MABA", b"Make America Based Again", b"Elon Musk envisions a future where true democracy thrives by supporting leaders like Trump, who prioritize freedom and innovation. He believes this approach can strengthen America's role as a beacon of democracy and shift focus away from conflicts. Musk champions a world where technological advancements lead to peace and prosperity, empowering individuals and driving economic growth through innovation, while making wars a thing of the past.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_00_57_43_1a5500201d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

