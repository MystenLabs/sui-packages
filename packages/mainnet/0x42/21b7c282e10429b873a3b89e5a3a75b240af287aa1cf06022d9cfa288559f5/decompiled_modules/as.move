module 0x4221b7c282e10429b873a3b89e5a3a75b240af287aa1cf06022d9cfa288559f5::as {
    struct AS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AS>(arg0, 9, b"AS", b"Asgard", b"Asgard is a boutique cannabis company founded in Southern California in 2014 by expert cultivators Neema and JB. Today, the company is owned and operated by Samari and childhood best friend Eran Haroni. Neem the dream and Bones grew up in SoCal together, born and raised on the beaches of Santa Monica with shared dreams of one day having a weed company with one specific goal in mind: to be able to provide their friends and family with the craziest weed they have ever seen or smoked.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3173acc00d3278c0734b3b7e8129d5bfblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

