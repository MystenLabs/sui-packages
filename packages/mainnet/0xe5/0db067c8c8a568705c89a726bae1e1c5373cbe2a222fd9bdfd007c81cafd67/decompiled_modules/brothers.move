module 0xe50db067c8c8a568705c89a726bae1e1c5373cbe2a222fd9bdfd007c81cafd67::brothers {
    struct BROTHERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROTHERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROTHERS>(arg0, 6, b"Brothers", b"Po Brothers", b"At Po' Brothers, we bring the flavors and traditions of globally-inspired cuisine to you. Our location is a celebration of Cajun and Creole cooking  some of the most soulful, delicious food in the world. From catfish to alligator, gumbo to jambalaya, our dishes are inspired by the rich culinary heritage of the Bayou.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ex6_IR_6o_Ah_QRBR_3z_P_28a8abce18.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROTHERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROTHERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

