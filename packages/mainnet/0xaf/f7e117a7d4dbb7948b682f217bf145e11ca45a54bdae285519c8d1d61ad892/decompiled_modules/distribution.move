module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::distribution {
    struct GiftcardKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct Giftcard has store, key {
        id: 0x2::object::UID,
        template: 0x2::object::ID,
        amount: u32,
    }

    struct GiftcardMinted has copy, drop {
        giftcard: 0x2::object::ID,
        template: 0x2::object::ID,
        amount: u32,
    }

    struct GiftcardRedeemed has copy, drop {
        giftcard: 0x2::object::ID,
        redeemer: address,
    }

    public fun new_giftcard(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: 0x1::string::String, arg3: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg4: u32, arg5: &0x2::tx_context::TxContext) : Giftcard {
        assert!(arg4 >= 1, 2404);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::assert_distribution(arg3, arg4);
        let v0 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_id(arg3);
        let v1 = GiftcardKey{pos0: arg2};
        let v2 = Giftcard{
            id       : 0x2::derived_object::claim<GiftcardKey>(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::uid_mut(arg0, arg1, arg5), v1),
            template : v0,
            amount   : arg4,
        };
        let v3 = GiftcardMinted{
            giftcard : 0x2::object::uid_to_inner(&v2.id),
            template : v0,
            amount   : arg4,
        };
        0x2::event::emit<GiftcardMinted>(v3);
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"giftcards"), arg2, arg5);
        v2
    }

    public(friend) fun redeem_giftcard(arg0: Giftcard, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg2: 0x1::option::Option<0x2::object::ID>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg6: &mut 0x2::tx_context::TxContext) {
        let Giftcard {
            id       : v0,
            template : v1,
            amount   : v2,
        } = arg0;
        let v3 = v0;
        assert!(0x2::object::id<0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate>(arg1) == v1, 2401);
        let v4 = GiftcardRedeemed{
            giftcard : 0x2::object::uid_to_inner(&v3),
            redeemer : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<GiftcardRedeemed>(v4);
        0x2::object::delete(v3);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::deposit(arg3, arg4, arg5, arg2, 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::mint_distribution(arg1, v2, arg6));
    }

    // decompiled from Move bytecode v7
}

