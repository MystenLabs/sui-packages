module 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin {
    struct Skin has store, key {
        id: 0x2::object::UID,
        final_salvation_id: 0x1::string::String,
        guid: 0x1::string::String,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        tier: 0x1::string::String,
        max_num_stamps_slot: u64,
        current_num_stamps: u64,
        stamps: 0x2::vec_map::VecMap<0x2::object::ID, 0x1::string::String>,
        champion_id: 0x1::string::String,
    }

    struct SkinStampKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct SkinMinted has copy, drop {
        minted_skin_id: 0x2::object::ID,
        final_salvation_id: 0x1::string::String,
        guid: 0x1::string::String,
        name: 0x1::string::String,
    }

    struct StampEquipped has copy, drop {
        skin_id: 0x2::object::ID,
        stamp_equipped_executor: address,
        equipped_stamp: 0x2::object::ID,
    }

    struct StampUnequipped has copy, drop {
        skin_id: 0x2::object::ID,
        stamp_unequipped_executor: address,
        unequipped_stamp: 0x2::object::ID,
    }

    public fun attach_skin_stamp(arg0: &mut Skin, arg1: 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::Stamp<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Skin, 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Container>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::id<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Skin, 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Container>(&arg1);
        assert!(!0x2::vec_map::contains<0x2::object::ID, 0x1::string::String>(&arg0.stamps, &v0), 0);
        assert!(arg0.max_num_stamps_slot > arg0.current_num_stamps, 2);
        let v1 = StampEquipped{
            skin_id                 : 0x2::object::uid_to_inner(&arg0.id),
            stamp_equipped_executor : 0x2::tx_context::sender(arg2),
            equipped_stamp          : 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::id<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Skin, 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Container>(&arg1),
        };
        0x2::event::emit<StampEquipped>(v1);
        let v2 = SkinStampKey{id: 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::id<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Skin, 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Container>(&arg1)};
        0x2::vec_map::insert<0x2::object::ID, 0x1::string::String>(&mut arg0.stamps, v2.id, 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::name<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Skin, 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Container>(&arg1));
        0x2::dynamic_object_field::add<SkinStampKey, 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::Stamp<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Skin, 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Container>>(&mut arg0.id, v2, arg1);
        arg0.current_num_stamps = arg0.current_num_stamps + 1;
    }

    public fun champion_id(arg0: &Skin) : 0x1::string::String {
        arg0.champion_id
    }

    public fun current_num_stamps(arg0: &Skin) : u64 {
        arg0.current_num_stamps
    }

    public fun detach_stamp(arg0: &mut Skin, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.current_num_stamps > 0, 3);
        assert!(0x2::vec_map::contains<0x2::object::ID, 0x1::string::String>(&arg0.stamps, &arg1), 1);
        let v0 = SkinStampKey{id: arg1};
        let (v1, _) = 0x2::vec_map::remove<0x2::object::ID, 0x1::string::String>(&mut arg0.stamps, &arg1);
        arg0.current_num_stamps = arg0.current_num_stamps - 1;
        let v3 = StampUnequipped{
            skin_id                   : 0x2::object::uid_to_inner(&arg0.id),
            stamp_unequipped_executor : 0x2::tx_context::sender(arg2),
            unequipped_stamp          : v1,
        };
        0x2::event::emit<StampUnequipped>(v3);
        0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::destroy<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Skin, 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Container>(0x2::dynamic_object_field::remove<SkinStampKey, 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::Stamp<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Skin, 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Container>>(&mut arg0.id, v0));
    }

    public fun final_salvation_id(arg0: &Skin) : 0x1::string::String {
        arg0.final_salvation_id
    }

    public fun guid(arg0: &Skin) : 0x1::string::String {
        arg0.guid
    }

    public fun image_url(arg0: &Skin) : 0x1::string::String {
        arg0.image_url
    }

    public fun max_num_stamps(arg0: &Skin) : u64 {
        arg0.max_num_stamps_slot
    }

    public fun mint(arg0: &mut 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::verification::Verifier, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) : Skin {
        let v0 = b"";
        let v1 = 0x1::string::utf8(b"skin");
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&v1));
        let v2 = 0x1::string::utf8(b"mint");
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::tx_context::sender(arg10)));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg7));
        0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::verification::verify_signature(arg0, 0x2::tx_context::sender(arg10), arg8, arg9, &mut v0);
        let v3 = Skin{
            id                  : 0x2::object::new(arg10),
            final_salvation_id  : arg1,
            guid                : arg2,
            name                : arg3,
            image_url           : arg4,
            tier                : arg5,
            max_num_stamps_slot : arg6,
            current_num_stamps  : 0,
            stamps              : 0x2::vec_map::empty<0x2::object::ID, 0x1::string::String>(),
            champion_id         : arg7,
        };
        let v4 = SkinMinted{
            minted_skin_id     : 0x2::object::id<Skin>(&v3),
            final_salvation_id : arg1,
            guid               : arg2,
            name               : arg3,
        };
        0x2::event::emit<SkinMinted>(v4);
        v3
    }

    public fun name(arg0: &Skin) : 0x1::string::String {
        arg0.name
    }

    public fun stamps(arg0: &Skin) : 0x2::vec_map::VecMap<0x2::object::ID, 0x1::string::String> {
        arg0.stamps
    }

    public fun tier(arg0: &Skin) : 0x1::string::String {
        arg0.tier
    }

    // decompiled from Move bytecode v6
}

