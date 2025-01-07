module 0x9b381c7922e034fee5e86ca44cbf99bc3fefe44109088fdddf261b1b53511517::skid {
    struct SKID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKID>(arg0, 6, b"Skid", b"Suicesskid", b"Success Kid is an Internet meme featuring a baby clenching a fistful of sand with a determined facial expression. It began in 2007 and eventually became known as \"Success Kid\". The popularity of the image led CNN to describe Sammy Griner, the boy depicted in the photo, as \"likely the Internet's most famous baby\".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5234_f5cd1acb9e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKID>>(v1);
    }

    // decompiled from Move bytecode v6
}

