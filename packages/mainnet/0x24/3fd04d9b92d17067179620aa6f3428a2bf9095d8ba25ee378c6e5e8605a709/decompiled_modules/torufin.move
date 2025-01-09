module 0x243fd04d9b92d17067179620aa6f3428a2bf9095d8ba25ee378c6e5e8605a709::torufin {
    struct TORUFIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORUFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORUFIN>(arg0, 6, b"Torufin", b"Torufin VilandSaga", b"Thorfinn ( Torufin?) Thorsson, also nicknamed Karlsefni, is the main protagonist of Vinland Saga. He is a former warrior of Askeladd's band as well as a former slave on Ketils farm who earned his freedom. Afterwards he became a trader and adventurer attempting to settle in Vinland.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thorfinn_profile_image_3_F1014_29_a1f3d02ab2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORUFIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORUFIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

