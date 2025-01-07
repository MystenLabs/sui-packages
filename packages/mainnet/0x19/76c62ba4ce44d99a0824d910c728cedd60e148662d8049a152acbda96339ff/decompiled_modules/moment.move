module 0x1976c62ba4ce44d99a0824d910c728cedd60e148662d8049a152acbda96339ff::moment {
    struct Moment has copy, drop, store {
        team: 0x1::string::String,
        player: 0x1::string::String,
        date: 0x1::string::String,
        play: 0x1::string::String,
        play_of_game: 0x1::string::String,
        game_clock: 0x1::string::String,
        audio_type: 0x1::string::String,
        video: 0x2::url::Url,
        total_editions: u32,
    }

    public fun audio_type(arg0: &Moment) : 0x1::string::String {
        arg0.audio_type
    }

    public fun date(arg0: &Moment) : 0x1::string::String {
        arg0.date
    }

    public fun game_clock(arg0: &Moment) : 0x1::string::String {
        arg0.game_clock
    }

    public fun new_moment(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u32) : Moment {
        Moment{
            team           : 0x1::string::utf8(arg0),
            player         : 0x1::string::utf8(arg1),
            date           : 0x1::string::utf8(arg2),
            play           : 0x1::string::utf8(arg3),
            play_of_game   : 0x1::string::utf8(arg4),
            game_clock     : 0x1::string::utf8(arg5),
            audio_type     : 0x1::string::utf8(arg6),
            video          : 0x2::url::new_unsafe_from_bytes(arg7),
            total_editions : arg8,
        }
    }

    public fun play(arg0: &Moment) : 0x1::string::String {
        arg0.play
    }

    public fun play_of_game(arg0: &Moment) : 0x1::string::String {
        arg0.play_of_game
    }

    public fun player(arg0: &Moment) : 0x1::string::String {
        arg0.player
    }

    public fun team(arg0: &Moment) : 0x1::string::String {
        arg0.team
    }

    public fun total_editions(arg0: &Moment) : u32 {
        arg0.total_editions
    }

    public fun update(arg0: &mut Moment, arg1: &Moment) {
        arg0.audio_type = arg1.audio_type;
        arg0.date = arg1.date;
        arg0.game_clock = arg1.game_clock;
        arg0.play = arg1.play;
        arg0.play_of_game = arg1.play_of_game;
        arg0.player = arg1.player;
        arg0.team = arg1.team;
        arg0.total_editions = arg1.total_editions;
        arg0.video = arg1.video;
    }

    public fun update_audio_type(arg0: &mut Moment, arg1: vector<u8>) {
        arg0.audio_type = 0x1::string::utf8(arg1);
    }

    public fun update_date(arg0: &mut Moment, arg1: vector<u8>) {
        arg0.date = 0x1::string::utf8(arg1);
    }

    public fun update_game_clock(arg0: &mut Moment, arg1: vector<u8>) {
        arg0.game_clock = 0x1::string::utf8(arg1);
    }

    public fun update_play(arg0: &mut Moment, arg1: vector<u8>) {
        arg0.play = 0x1::string::utf8(arg1);
    }

    public fun update_play_of_game(arg0: &mut Moment, arg1: vector<u8>) {
        arg0.play_of_game = 0x1::string::utf8(arg1);
    }

    public fun update_player(arg0: &mut Moment, arg1: vector<u8>) {
        arg0.player = 0x1::string::utf8(arg1);
    }

    public fun update_team(arg0: &mut Moment, arg1: vector<u8>) {
        arg0.team = 0x1::string::utf8(arg1);
    }

    public fun update_total_editions(arg0: &mut Moment, arg1: u32) {
        arg0.total_editions = arg1;
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

