module 0x9a63d7d8dc36d5f105dc0a3dbf3040d63f314de00d89882d94f82051e6e61845::asg {
    struct ASG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASG>(arg0, 9, b"ASG", b"Asgard", b"Asgard is a boutique cannabis company founded in Southern California in 2014 by expert cultivators Neema and JB. Today, the company is owned and operated by Samari and childhood best friend Eran Haroni. Neem the dream and Bones grew up in SoCal together, born and raised on the beaches of Santa Monica with shared dreams of one day having a weed company with one specific goal in mind: to be able to provide their friends and family with the craziest weed they have ever seen or smoked : Official coin Asgard LLC: 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/efee81d192a9c12f31a3d8478632054fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

