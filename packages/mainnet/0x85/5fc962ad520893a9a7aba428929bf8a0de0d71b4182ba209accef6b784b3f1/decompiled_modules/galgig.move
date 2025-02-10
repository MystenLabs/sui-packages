module 0x855fc962ad520893a9a7aba428929bf8a0de0d71b4182ba209accef6b784b3f1::galgig {
    struct GALGIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GALGIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GALGIG>(arg0, 9, b"GalGig", b"GalacticGiggles", x"47616c6163746963476967676c65732077617320626f726e207768656e20612067726f7570206f6620616c69656e73206465636964656420746f207475726e207468656972206d6f737420656d62617272617373696e67206d6f6d656e7420696e746f2061206d656d652e20497420717569636b6c7920626563616d65207468652063757272656e6379206f66207468652067616c6178792c207573656420666f722065766572797468696e672066726f6d20627579696e672073746172736869707320746f20706179696e6720666f72e6989fe99985e7ac91e8af9de5b881e38082", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dstqcb0lj/image/upload/v1739209759/opz9jroyjfn6zlzhfoxm.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GALGIG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GALGIG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

