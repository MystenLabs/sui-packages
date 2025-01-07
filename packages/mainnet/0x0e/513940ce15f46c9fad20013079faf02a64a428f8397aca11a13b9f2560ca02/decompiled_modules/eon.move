module 0xe513940ce15f46c9fad20013079faf02a64a428f8397aca11a13b9f2560ca02::eon {
    struct EON has drop {
        dummy_field: bool,
    }

    fun init(arg0: EON, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<EON>(arg0, 5175232634829590224, b"Eye of Newt", b"EON", b"Eye of newt (EON) is used in Herblore to make attack potions and super attack potions. One eye of newt is needed for the Witch's Potion and Recipe for Disaster quests. After completing Tower of Life, it can be used to dominate the cryptosphere.", b"https://images.hop.ag/ipfs/QmNzA2fE62KET9Yn97bEaka95Sydd2ozMzUQffVKk1tDfB", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/+uYci8e4Dqig5ODhh"), arg1);
    }

    // decompiled from Move bytecode v6
}

