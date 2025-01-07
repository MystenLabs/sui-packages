module 0x86d9176ad26e83d6e617768a19a67aeac2808a95983cc752841689cee89f0ef2::moment {
    struct Moment has copy, drop, store {
        series: 0x1::string::String,
        set: 0x1::string::String,
        rarity: 0x1::string::String,
        team: 0x1::string::String,
        player: 0x1::string::String,
        date: 0x1::string::String,
        play: 0x1::string::String,
        audio_type: 0x1::string::String,
        video: 0x2::url::Url,
    }

    public fun audio_type(arg0: &Moment) : 0x1::string::String {
        arg0.audio_type
    }

    fun build_field_template(arg0: vector<u8>, arg1: vector<u8>) : 0x1::string::String {
        let v0 = b"{";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, b".");
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, b"}");
        0x1::string::utf8(v0)
    }

    public fun date(arg0: &Moment) : 0x1::string::String {
        arg0.date
    }

    public fun get_display_kvp(arg0: vector<u8>) : (vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"series"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"set"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"team"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"player"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"date"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"play"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"audio_type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"video"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, build_field_template(arg0, b"series"));
        0x1::vector::push_back<0x1::string::String>(v3, build_field_template(arg0, b"set"));
        0x1::vector::push_back<0x1::string::String>(v3, build_field_template(arg0, b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v3, build_field_template(arg0, b"team"));
        0x1::vector::push_back<0x1::string::String>(v3, build_field_template(arg0, b"player"));
        0x1::vector::push_back<0x1::string::String>(v3, build_field_template(arg0, b"date"));
        0x1::vector::push_back<0x1::string::String>(v3, build_field_template(arg0, b"play"));
        0x1::vector::push_back<0x1::string::String>(v3, build_field_template(arg0, b"audio_type"));
        0x1::vector::push_back<0x1::string::String>(v3, build_field_template(arg0, b"video"));
        (v0, v2)
    }

    public fun new_moment(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>) : Moment {
        Moment{
            series     : 0x1::string::utf8(arg0),
            set        : 0x1::string::utf8(arg1),
            rarity     : 0x1::string::utf8(arg2),
            team       : 0x1::string::utf8(arg3),
            player     : 0x1::string::utf8(arg4),
            date       : 0x1::string::utf8(arg5),
            play       : 0x1::string::utf8(arg6),
            audio_type : 0x1::string::utf8(arg7),
            video      : 0x2::url::new_unsafe_from_bytes(arg8),
        }
    }

    public fun play(arg0: &Moment) : 0x1::string::String {
        arg0.play
    }

    public fun player(arg0: &Moment) : 0x1::string::String {
        arg0.player
    }

    public fun rarity(arg0: &Moment) : 0x1::string::String {
        arg0.rarity
    }

    public fun series(arg0: &Moment) : 0x1::string::String {
        arg0.series
    }

    public fun set(arg0: &Moment) : 0x1::string::String {
        arg0.set
    }

    public fun team(arg0: &Moment) : 0x1::string::String {
        arg0.team
    }

    public fun update_audio_type(arg0: &mut Moment, arg1: vector<u8>) {
        arg0.audio_type = 0x1::string::utf8(arg1);
    }

    public fun update_date(arg0: &mut Moment, arg1: vector<u8>) {
        arg0.date = 0x1::string::utf8(arg1);
    }

    public fun update_play(arg0: &mut Moment, arg1: vector<u8>) {
        arg0.play = 0x1::string::utf8(arg1);
    }

    public fun update_player(arg0: &mut Moment, arg1: vector<u8>) {
        arg0.player = 0x1::string::utf8(arg1);
    }

    public fun update_rarity(arg0: &mut Moment, arg1: vector<u8>) {
        arg0.rarity = 0x1::string::utf8(arg1);
    }

    public fun update_series(arg0: &mut Moment, arg1: vector<u8>) {
        arg0.series = 0x1::string::utf8(arg1);
    }

    public fun update_set(arg0: &mut Moment, arg1: vector<u8>) {
        arg0.set = 0x1::string::utf8(arg1);
    }

    public fun update_team(arg0: &mut Moment, arg1: vector<u8>) {
        arg0.team = 0x1::string::utf8(arg1);
    }

    public fun update_video(arg0: &mut Moment, arg1: vector<u8>) {
        arg0.video = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    public fun video(arg0: &Moment) : 0x1::string::String {
        let v0 = 0x2::url::inner_url(&arg0.video);
        0x1::string::utf8(*0x1::ascii::as_bytes(&v0))
    }

    // decompiled from Move bytecode v6
}

