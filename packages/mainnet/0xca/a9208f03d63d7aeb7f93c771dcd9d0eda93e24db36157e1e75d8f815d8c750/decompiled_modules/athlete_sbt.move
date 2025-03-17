module 0xcaa9208f03d63d7aeb7f93c771dcd9d0eda93e24db36157e1e75d8f815d8c750::athlete_sbt {
    struct AthleteSbtMintEvent has copy, drop {
        id: 0x2::object::ID,
        identifier: u64,
        name: 0x1::string::String,
        country: 0x1::string::String,
        image_url: 0x2::url::Url,
        recipient: address,
    }

    struct UpdateCapMintEvent has copy, drop {
        id: 0x2::object::ID,
        athlete_identifier: u64,
        image_url: 0x2::url::Url,
        recipient: address,
    }

    struct AthleteSbtBurnEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct AthleteSbtUpdateEvent has copy, drop {
        athlete_sbt_id: 0x2::object::ID,
        update_cap_id: 0x2::object::ID,
        identifier: u64,
        image_url: 0x2::url::Url,
    }

    struct AthleteSbt has key {
        id: 0x2::object::UID,
        identifier: u64,
        name: 0x1::string::String,
        country: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct UpdateCap has key {
        id: 0x2::object::UID,
        athlete_identifier: u64,
        image_url: 0x2::url::Url,
    }

    public fun burn_athlete_sbt(arg0: AthleteSbt) {
        let v0 = AthleteSbtBurnEvent{id: 0x2::object::id<AthleteSbt>(&arg0)};
        0x2::event::emit<AthleteSbtBurnEvent>(v0);
        let AthleteSbt {
            id         : v1,
            identifier : _,
            name       : _,
            country    : _,
            image_url  : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun get_country(arg0: &AthleteSbt) : 0x1::string::String {
        arg0.country
    }

    public fun get_identifier(arg0: &AthleteSbt) : u64 {
        arg0.identifier
    }

    public fun get_image_url(arg0: &AthleteSbt) : 0x2::url::Url {
        arg0.image_url
    }

    public fun get_name(arg0: &AthleteSbt) : 0x1::string::String {
        arg0.name
    }

    public fun mint_athlete_sbt(arg0: &0x81ce93535c2412a4a987944e9f9578e0caf937d21dcf8c071e3d612b5149003c::admin::AdminCap, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = AthleteSbt{
            id         : 0x2::object::new(arg6),
            identifier : arg5,
            name       : 0x1::string::utf8(arg2),
            country    : 0x1::string::utf8(arg3),
            image_url  : 0x2::url::new_unsafe_from_bytes(arg4),
        };
        let v1 = AthleteSbtMintEvent{
            id         : 0x2::object::id<AthleteSbt>(&v0),
            identifier : v0.identifier,
            name       : v0.name,
            country    : v0.country,
            image_url  : v0.image_url,
            recipient  : arg1,
        };
        0x2::event::emit<AthleteSbtMintEvent>(v1);
        0x2::transfer::transfer<AthleteSbt>(v0, arg1);
    }

    public fun mint_update_cap(arg0: &0x81ce93535c2412a4a987944e9f9578e0caf937d21dcf8c071e3d612b5149003c::admin::AdminCap, arg1: address, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateCap{
            id                 : 0x2::object::new(arg4),
            athlete_identifier : arg2,
            image_url          : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v1 = UpdateCapMintEvent{
            id                 : 0x2::object::id<UpdateCap>(&v0),
            athlete_identifier : v0.athlete_identifier,
            image_url          : v0.image_url,
            recipient          : arg1,
        };
        0x2::event::emit<UpdateCapMintEvent>(v1);
        0x2::transfer::transfer<UpdateCap>(v0, arg1);
    }

    public fun update_athlete_sbt(arg0: UpdateCap, arg1: &mut AthleteSbt) {
        if (arg0.athlete_identifier == arg1.identifier) {
            arg1.image_url = arg0.image_url;
            let v0 = AthleteSbtUpdateEvent{
                athlete_sbt_id : 0x2::object::id<AthleteSbt>(arg1),
                update_cap_id  : 0x2::object::id<UpdateCap>(&arg0),
                identifier     : arg1.identifier,
                image_url      : arg1.image_url,
            };
            0x2::event::emit<AthleteSbtUpdateEvent>(v0);
        };
        let UpdateCap {
            id                 : v1,
            athlete_identifier : _,
            image_url          : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    // decompiled from Move bytecode v6
}

