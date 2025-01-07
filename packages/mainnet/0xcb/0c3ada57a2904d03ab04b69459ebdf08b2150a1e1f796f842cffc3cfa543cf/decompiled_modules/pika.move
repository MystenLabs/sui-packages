module 0xcb0c3ada57a2904d03ab04b69459ebdf08b2150a1e1f796f842cffc3cfa543cf::pika {
    struct PIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKA>(arg0, 9, b"PIKA", b"Suikachu", x"5375696b61636875202850494b412920e2809320546865206c696768746e696e672d6661737420746f6b656e206f66207468652053756920626c6f636b636861696e21204167696c652c2066756e2c20616e642063686172676564207769746820706f7765722c205375696b6163687520737061726b73206578636974656d656e7420696e206576657279207472616e73616374696f6e2c207768657468657220796f752772652074726164696e67206f7220686f6c64696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/818433502311919616/9QKB5KRc.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIKA>(&mut v2, 200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

