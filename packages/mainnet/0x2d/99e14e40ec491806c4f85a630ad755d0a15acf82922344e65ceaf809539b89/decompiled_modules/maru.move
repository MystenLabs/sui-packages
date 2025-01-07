module 0x2d99e14e40ec491806c4f85a630ad755d0a15acf82922344e65ceaf809539b89::maru {
    struct MARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARU>(arg0, 6, b"MARU", b"MARU TARO", b"Neiro is not the most famous shiba inu. Meet Maru, the Shiba Inu who took over the world with nothing but his fluffy charm and a wagging tail! Why scroll through boring investments when you can follow the paws of Worlds most famous dog? Maru's not just a social media sensation, hes the face of fun, loyalty, andyesadventures in crypto! Join the Maru taro revolution, where every dog has its day, and every investor can have a howling good time. Dont miss out on the purrfect investment!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Maru_bb0a43dd60.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

