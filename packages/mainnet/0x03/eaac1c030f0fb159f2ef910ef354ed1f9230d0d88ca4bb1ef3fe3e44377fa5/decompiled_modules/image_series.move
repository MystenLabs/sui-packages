module 0x3eaac1c030f0fb159f2ef910ef354ed1f9230d0d88ca4bb1ef3fe3e44377fa5::image_series {
    struct IMAGE_SERIES has drop {
        dummy_field: bool,
    }

    struct ImageSeries has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        quilt_id: 0x1::string::String,
        eligible_tamashi: vector<u8>,
    }

    struct ImageSeriesRegistry has key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &0x3eaac1c030f0fb159f2ef910ef354ed1f9230d0d88ca4bb1ef3fe3e44377fa5::admin::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &mut ImageSeriesRegistry) {
        0x2::transfer::freeze_object<ImageSeries>(new_impl(arg1, arg2, arg3, arg4));
    }

    public(friend) fun assert_is_eligible_tamashi(arg0: &ImageSeries, arg1: u8) {
        assert!(0x1::vector::contains<u8>(eligible_tamashi(arg0), &arg1), 0);
    }

    public fun eligible_tamashi(arg0: &ImageSeries) : &vector<u8> {
        &arg0.eligible_tamashi
    }

    public fun id(arg0: &ImageSeries) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: IMAGE_SERIES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ImageSeriesRegistry{id: 0x2::object::new(arg1)};
        let v1 = b"";
        let v2 = 0;
        while (v2 < 100) {
            0x1::vector::push_back<u8>(&mut v1, (v2 as u8) + 1);
            v2 = v2 + 1;
        };
        let v3 = &mut v0;
        0x2::transfer::freeze_object<ImageSeries>(new_impl(0x1::string::utf8(b"ORIGINAL"), 0x1::string::utf8(b"hAKUrbgRtn63UDGulNOWIGicUgt_kwkAkwCjcvYhxlY"), v1, v3));
        0x2::transfer::share_object<ImageSeriesRegistry>(v0);
    }

    public fun name(arg0: &ImageSeries) : 0x1::string::String {
        arg0.name
    }

    fun new_impl(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &mut ImageSeriesRegistry) : ImageSeries {
        0x1::vector::reverse<u8>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg2)) {
            let v1 = 0x1::vector::pop_back<u8>(&mut arg2);
            assert!(v1 >= 1 && v1 <= 100, 1);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<u8>(arg2);
        ImageSeries{
            id               : 0x2::derived_object::claim<0x1::string::String>(&mut arg3.id, arg0),
            name             : arg0,
            quilt_id         : arg1,
            eligible_tamashi : 0x2::vec_set::into_keys<u8>(0x2::vec_set::from_keys<u8>(arg2)),
        }
    }

    public fun quilt_id(arg0: &ImageSeries) : 0x1::string::String {
        arg0.quilt_id
    }

    // decompiled from Move bytecode v6
}

