module 0x825d385ad9d60e12fa25c190dca9f2441479a97ef48b445f7bfcc98c551f50f3::sht {
    struct SHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHT>(arg0, 6, b"SHT", b"MasterShit", b"We want to try to list in this project everything that in your opinion is shit in this world. Contests and partnerships will be created to involve the crypto space and not only...In an ironic way we will make our voice heard. Join this shitty world. Soon we will reveal Site and account X with all the details!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Shit_Master_634f553ddc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

