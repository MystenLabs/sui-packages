module 0x75b4946e3f08307df1772f87648f7b5c6cc5e0510bb1ec03259e2ff54cb8760f::mgo {
    struct MGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGO>(arg0, 6, b"MGO", b"Goose Mining", b"hatching As the name suggests. A token to create the zero phase of a goose breeding farm both in real and as a virtual site, both of which will be mined and converted with direct communication based on the available number. Soon the link of the site and Twitter group will be updated in this section. Your trust is our capital and it will be a two-way and permanent benefit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GOOSE_TOKEN_459dafeffa.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

